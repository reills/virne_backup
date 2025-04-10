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
  id 1316
  arrival_time 27502.5107922985
  lifetime 2295.0269298703283
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 8
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 49
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 27
    gpu 2
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 21
    rom 8
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 10
    rom 3
  ]
  node [
    id 5
    label "5"
    cpu 7
    gpu 9
    rom 22
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 40
    rom 45
  ]
  node [
    id 7
    label "7"
    cpu 19
    gpu 1
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 10
  ]
  edge [
    source 4
    target 5
    bw 0
  ]
  edge [
    source 5
    target 6
    bw 27
  ]
  edge [
    source 6
    target 7
    bw 6
  ]
]
