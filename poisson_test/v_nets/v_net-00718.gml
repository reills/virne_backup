graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 718
  arrival_time 15040.093116429618
  lifetime 649.7031254034314
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 20
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 6
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 0
    gpu 27
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 28
    rom 15
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 42
    rom 46
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 24
    rom 14
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
]
