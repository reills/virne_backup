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
  id 1470
  arrival_time 31944.242908110275
  lifetime 3005.7093001681287
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 19
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 20
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 43
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 43
    rom 32
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 27
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 9
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
]
