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
  id 102
  arrival_time 1970.4288747809849
  lifetime 1606.073005184926
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 43
    gpu 12
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 32
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 34
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 34
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 50
    gpu 29
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 36
  ]
  edge [
    source 1
    target 2
    bw 36
  ]
  edge [
    source 2
    target 3
    bw 46
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
]
