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
  id 945
  arrival_time 20146.77142171327
  lifetime 2935.0550634761894
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 27
    rom 30
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 14
    rom 36
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 28
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 18
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
]
